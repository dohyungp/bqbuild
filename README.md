# BQbuild

Cloudbuild setting for versioning Biquery Procedures.

## How to setup

First of all, you should enable **Cloud Build API** and **Source Repository** on google cloud.


### 1. Create Cloud Source Repository

* visit [Cloud source repository](https://source.cloud.google.com/) and push this source code.

### 2. Create Cloud build trigger

Replace gcloud cli arguments.

* `<trigger-name>`: trigger name(e.g `bigquery-procedure-trigger`)
* `<procedure-repository-name>`: source repository name what you created before step 1.
* `<branch-pattern>`: branch-pattern(e.g `^master*`, `^release*`)

```sh
$ gcloud beta builds triggers create cloud-source-repositories  --name="<trigger-name>" --repo="<procedure-repository-name>" --branch-pattern="<branch-pattern>"  --build-config="cloudbuild.yaml"
```

### 3. Add BigQuery Job Role to Cloud build Service Account

Replace gcloud cli arguments.

`<cloudbuild-user>`: when you enabled it user is created on service account. please find and replace it for add `bigquery.jobUser` role.

```sh
$ gcloud projects add-iam-policy-binding my-project \
    --member=user:<cloudbuild-user>@cloudbuild.gserviceaccount.com --role=roles/bigquery.jobUser
```

Setup is finished!