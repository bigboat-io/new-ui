module.exports =
  appSearchChanged: (value) ->
    type: 'APP_SEARCH_CHANGED'
    value: value
  appstoreSearchChanged: (value) ->
    type: 'APPSTORE_SEARCH_CHANGED'
    value: value
  bucketSearchChanged: (value) ->
    type: 'BUCKET_SEARCH_CHANGED'
    value: value