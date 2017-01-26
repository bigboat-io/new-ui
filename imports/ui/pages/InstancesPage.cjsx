{ Meteor }          = require 'meteor/meteor'
React               = require 'react'
G                   = require 'grommet'
{ browserHistory }  = require 'react-router'
Helpers             = require '../Helpers.coffee'

module.exports = React.createClass
  displayName: 'InstancesPage'

  render: ->
    console.log @
    <G.Section pad='none'>
      <G.Header size='small' justify='start' separator='top' pad={horizontal:'small'}>
        <G.Label size='small'>Today</G.Label>
      </G.Header>
      <G.Tiles selectable=true pad={horizontal:'small'} fill=false flush=false responsive=false>
        {@props.instances.map (instance) ->
          onTileClick = -> browserHistory.push "/instances/#{instance.name}"
          instanceHelper = Helpers.withInstance instance
          <G.Tile key={instance._id} align='stretch' pad='small' direction='row' size={width: {min: 'small'}} onClick={onTileClick}>
            <G.Box>
              <strong>{instance.name}</strong>
              <G.Box direction='row'>
                <G.Icons.Status value={instanceHelper.getStateValue()} size='small' />
                <span className='secondary'>{instanceHelper.getStatusText()}</span>
              </G.Box>
            </G.Box>
          </G.Tile>
        }
      </G.Tiles>
    </G.Section>