# Usage


## Indexes

https://firebase.google.com/docs/firestore/query-data/index-overview?authuser=0#composite_indexes

```bash
firebase deploy --only firestore:indexes
gcloud firestore operations list
gcloud firestore operations describe [OPERATION_NAME]
```

## Data transfer


```bash
COLLECTIONS_TO_TRANSFER="memes" # "foo,bar,baz"
gcloud projects list
gcloud config set project langame-86ac4
BUCKET_PROD="gs://langame-exports"
# location matters, you are not allowed to export to different region...
gsutil mb -l europe-west1 $BUCKET_PROD
gcloud firestore export $BUCKET_PROD --collection-ids=$COLLECTIONS_TO_TRANSFER
rm -rf /tmp/export && mkdir -p /tmp/export
gsutil -m cp -r $BUCKET_PROD/* /tmp/export
gcloud config set project langame-dev
BUCKET_DEV="gs://langame-firestore"
gsutil mb -l europe-west1 $BUCKET_DEV
gsutil -m mv /tmp/export/* $BUCKET_DEV
EXPORT_DIR=$(gsutil ls $BUCKET_PROD | grep "202" | tail -n1)
gcloud firestore import "$EXPORT_DIR" --collection-ids="$COLLECTIONS_TO_TRANSFER"

```