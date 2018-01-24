_           = require 'lodash'
{ connect } = require 'react-redux'
{ newInstancePageCloseRequest } = require '/imports/redux/actions/newInstance.coffee'
{ startAppRequest } = require '/imports/redux/actions/apps.coffee'

mapStateToProps = (state, { params, location }) ->
  query = location.query
  selectedAppName = params.name or null
  selectedAppVersion = params.version or null
  apps: state.collections.apps?.map (a) -> _id: a._id, name: a.name, version: a.version or []
  buckets: state.collections.buckets?.map (b) -> b.name
  name: query?.name
  bucket: query?.bucket
  appsearch: query?.appsearch
  selectedApp: _.find state.collections.apps, (name: selectedAppName, version: selectedAppVersion)
  selectedAppName: selectedAppName
  selectedAppVersion: selectedAppVersion
  appParams: _.fromPairs(_.filter _.toPairs(query), ([key]) -> key.match "^param_")

mapDispatchToProps = (dispatch) ->
  onStateChanged: (state) ->
    dispatch Object.assign (type: 'START_APP_FORM_REQUEST'), state
  onClose: (name, version) -> dispatch newInstancePageCloseRequest name, version
  onStartInstance: (appName, version, instanceName) ->
    dispatch startAppRequest appName, version, instanceName

mergeProps = (stateProps, dispatchProps, ownProps) ->
  state =
    app:
      name: stateProps.selectedAppName
      version: stateProps.selectedAppVersion
    params: Object.assign {}, stateProps.appParams,
      name: stateProps.name
      bucket: stateProps.bucket
      appsearch: stateProps.appsearch

  Object.assign {}, stateProps, dispatchProps, ownProps,
    onStateChanged: (stateDiff) ->
      dispatchProps.onStateChanged Object.assign {}, state, params: (Object.assign {}, state.params, stateDiff)
    onAppSelected: (name, version) ->
      dispatchProps.onStateChanged Object.assign {}, state, app: {name: name, version:version}
    onClose: -> dispatchProps.onClose state.app.name, state.app.version
    onStartInstance: ->
      console.log 'state', state
      dispatchProps.onStartInstance state.app.name, state.app.version, state.params.name

module.exports = connect(mapStateToProps, mapDispatchToProps, mergeProps) require '../NewInstancePage'