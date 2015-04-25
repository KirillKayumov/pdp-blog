class Alerts
  alerts = $('.alert-box')

  constructor: ->
    Alerts = this

  setTimeout(
    () ->
      alerts.find('a.close').click()
    , 5000
  )

window.Alerts = Alerts
