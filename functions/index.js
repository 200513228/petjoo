const functions = require("firebase-functions");
const admin = require("firebase-admin");
const FieldValue = require("firebase-admin").firestore.FieldValue;

const firebase = admin.initializeApp();
const db = firebase.firestore();
const storage = firebase.storage();


exports.deleteUserData = functions.auth.user().onDelete(async (event) => {
    const userId = event.data.uid;
    //Delete User Adverts
    db.collection("adverts").where("userId", isEqualTo = snap.id).delete();
    const linksRef = database.collection('adverts').where("userId", isEqualTo = snap.id);
    const deleteLinks = deleteCollection(linksRef, BATCH_SIZE)

    //Delete User Images

    const bucket = storage.bucket();
    await bucket.deleteFiles({
        prefix: 'user_images/' + snap.id + '.jpg'
    });

    //Delete User
    db.collection("users_info").doc(snap.id).delete();

    return Promise.all([deleteLinks]).then(() => {
        return database.collection('users').doc(userId).delete();
    });
});

exports.userUpdateFunction = functions
    .region('europe-west6')
    .firestore
    .document("users/{userId}")
    .onUpdate(async (snap, context) => {
        const oldData = snap.before.data();
        const newData = snap.after.data();
        if (oldData.name != newData.name || oldData.surname != newData.surname) {
            db.collection("users_info").doc(snap.after.id).update({ name: newData.name, surname: newData.surname });
        }
        if (oldData.hasTransport != newData.hasTransport) {
            db.collection("transport_adverts").doc(snap.after.id).update({ isActive: newData.hasTransport });
        }
    });

    exports.userCreateFunction = functions
    .region('europe-west6')
    .firestore
    .document("users/{userId}")
    .onCreate(async (snap, context) => {
        const user = snap.data();
        db.collection("users_info").doc(snap.params.userId).update({ name: user.name, surname: user.surname, image: user.image });
    });

exports.transportReservationCreateFunction = functions
    .region('europe-west6')
    .firestore
    .document("transport_reservations/{reservationId}")
    .onCreate(async (snap, context) => {
        const reservation = snap.data();
        const user = (await db.collection("users").doc(reservation.userId).get()).data()
        const fcmToken = (await db.collection("users").doc(reservation.advertId).get()).data().fcmToken;
        const title = "Rezervasyon İsteğiniz Var!";
        const body = user.name + " " + user.surname + " adına yeni bir rezervasyon isteğiniz var!"

        admin.messaging().sendToDevice(
            fcmToken,
            {
                notification: {
                    title: title,
                    body: body,
                },
                data: {
                    reservationId: snap.id,
                    click_action: "FLUTTER_NOTIFICATION_CLICK",
                }
            },
        );
    });

exports.transportReservationUpdateFunction = functions
    .region('europe-west6')
    .firestore
    .document("transport_reservations/{reservationId}")
    .onUpdate(async (snap, context) => {
        const oldData = snap.before.data();
        const newData = snap.after.data();
        if (oldData.status != newData.status) {
            const fcmToken = (await db.collection("users").doc(newData.userId).get()).data().fcmToken;
            var title = "";
            var body = "";
            if (newData.status == 1) {
                title = "Rezervasyon Reddedildi!";
                body = newData.title + " için rezervayonunuz ilan sahibi tarafından reddedildi."
            }
            else {
                title = "Rezervasyon Onaylandı!";
                body = newData.title + " için rezervayonunuz ilan sahibi tarafından onaylandı."
            }
            admin.messaging().sendToDevice(
                fcmToken,
                {
                    notification: {
                        title: title,
                        body: body,
                    },
                    data: {
                        reservationId: snap.after.id,
                        click_action: "FLUTTER_NOTIFICATION_CLICK",
                    }
                },
            );
        }
    });

exports.deleteAdvertFunction = functions
    .region('europe-west6')
    .firestore
    .document("adverts/{advertId}")
    .onDelete(async (snap, context) => {
        const bucket = storage.bucket();
        bucket.deleteFiles({
            prefix: 'advert_images/' + snap.id
        });
    });

exports.chatNotificationFunction = functions
    .region('europe-west6')
    .firestore
    .document("chats/{chatId}/messages/{messageId}")
    .onCreate(async (snap, context) => {
        const message = snap.data();
        const chatRef = snap.ref.parent.parent;
        const chatDoc = await chatRef.get();
        const chat = chatDoc.data();
        message.id = snap.id;
        chatRef.update({
            lastMessage: message,
        });
        const receiverId = chat.userIds[0] == message.senderId ? chat.userIds[1] : chat.userIds[0];
        const sender = (await db.collection("users").doc(message.senderId).get()).data();
        const receiver = (await db.collection("users").doc(receiverId).get()).data();
        return admin.messaging().sendToDevice(
            receiver.fcmToken,
            {
                notification: {
                    title: sender.name + " " + sender.surname,
                    body: message.content,
                },
                data: {
                    chatId: chatDoc.id,
                    click_action: "FLUTTER_NOTIFICATION_CLICK",
                }
            },
        );
    });

exports.chatUpdateFunction = functions
    .region('europe-west6')
    .firestore
    .document("chats/{chatId}/messages/{messageId}")
    .onUpdate(async (snap, context) => {
        const message = snap.after.data();
        const chatRef = snap.after.ref.parent.parent;
        const chatDoc = await chatRef.get();
        const chat = chatDoc.data();
        if (chat.lastMessage.id == snap.after.id) {
            message.id = snap.after.id;
            chatRef.update({
                lastMessage: message,
            });
        }
    });

function deleteCollection(collectionRef, batchSize) {
    var query = collectionRef.orderBy('__name__').limit(batchSize)

    return new Promise(function (resolve, reject) {
        deleteQueryBatch(query, resolve)
    })
}

async function deleteQueryBatch(query, resolve) {
    const snapshot = await query.get();

    const batchSize = snapshot.size;
    if (batchSize === 0) {
        // When there are no documents left, we are done
        resolve();
        return;
    }

    // Delete documents in a batch
    const batch = db.batch();
    snapshot.docs.forEach((doc) => {
        batch.delete(doc.ref);
    });
    await batch.commit();

    // Recurse on the next process tick, to avoid
    // exploding the stack.
    process.nextTick(() => {
        deleteQueryBatch(query, resolve);
    });
}
