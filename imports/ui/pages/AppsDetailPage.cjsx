React         = require 'react'
DetailPage    = require '../DetailPage.cjsx'

{ Header, Box, Split, Sidebar, Tabs, Tab } = require 'grommet'
AppControls = require '../menus/AppControls.cjsx'
YamlEditor  = require '../editors/YamlEditor.cjsx'
Loading     = require '../Loading.cjsx'

module.exports = React.createClass
  displayName: 'AppsDetailPage'

  getInitialState: ->
    dockerCompose: @props.dockerCompose
    bigboatCompose: @props.bigboatCompose

  render: ->
    <Loading isLoading={@props.isLoading} render={@renderWithData} />

  onComposeChange: (yamlobj, code) ->
    @setState dockerCompose: code
  onBigboatChange: (yamlobj, code) ->
    console.log yamlobj
    @setState bigboatCompose: code
    @setState name: yamlobj.name
    @setState version: yamlobj.version
  onSaveApp: -> @props.onSaveApp @state.dockerCompose, @state.bigboatCompose, @state.name, @state.version
  isSaveButtonDisabled: ->
    sdc = @state.dockerCompose
    sbc = @state.bigboatCompose
    (sdc is @props.dockerCompose or not sdc?) and
    (sbc is @props.bigboatCompose or not sbc?)

  renderWithData: ->
    <Split flex='left' priority='left'>
      <DetailPage title={@props.title} >
        <Tabs style={marginBottom:0} responsive={false}>
          <Tab title='Docker Compose'>
            <YamlEditor name='dockerCompose' code={@state.dockerCompose or @props.dockerCompose} onChange={@onComposeChange} />
          </Tab>
          <Tab title='BigBoat Compose'>
            <YamlEditor name='bigboatCompose' code={@state.bigboatCompose or @props.bigboatCompose} onChange={@onBigboatChange} />
          </Tab>
        </Tabs>
      </DetailPage>
      <Sidebar size='medium' colorIndex='light-2' direction='column'>
        <Header pad='medium' size='large' />
        <AppControls
          saveButtonDisabled={@isSaveButtonDisabled()}
          removeButtonDisabled={@props.isNewApp}
          startButtonDisabled={@props.isNewApp}
          onSaveApp={@onSaveApp}
          onRemoveApp={@props.onRemoveApp}
          onStartApp={@props.onStartApp}
          name={@props.title} />
      </Sidebar>
    </Split>
