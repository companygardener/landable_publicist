Publicist.PageDeactivateController = Ember.ObjectController.extend

  actions:
    deactivate: ->
      adapter = @get('model.adapter')
      page = @get('model')
      url = adapter.buildURL('page', page.id)

      request = adapter.ajax url, 'DELETE'

      request.then ->
        Publicist.messages.add 'Successfully trashed.', level: 'success', title: 'Trashed'
        page.rollback()
        page.reload()

        $('.modal:visible').modal('hide')

      request.then null, ->
        Publicist.messages.add 'Trashed was not successful.', level: 'error', title: 'Not Trashed'
