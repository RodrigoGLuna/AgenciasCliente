package appcliente

import grails.converters.JSON
import groovy.json.JsonSlurper

class ClienteController {

    def index() {}

    def cargaDatos() {

        def res
        switch (params.criterio) {
            case "0":
                res = null
                break
            case "1":
                res = 'ADDRESS_LINE'
                break
            case "2":
                res = 'AGENCY_CODE'
                break
            case "3":
                res = 'DISTANCE'
                break

        }
        def url
        if (res == null && params.limite == "") {
            url = new URL("http://localhost:4567/agencias?site_id=" + params.site_id + "&payment_method_id=" + params.payment_method_id + "&latitud=" + params.latitud + "&longitud=" + params.longitud);
        } else if (res == null && params.limite != "") {
            url = new URL("http://localhost:4567/agencias?site_id=" + params.site_id + "&payment_method_id=" + params.payment_method_id + "&latitud=" + params.latitud + "&longitud=" + params.longitud + "&limite=" + params.limite);
        } else if (res != null && params.limite == "") {
            url = new URL("http://localhost:4567/agencias?site_id=" + params.site_id + "&payment_method_id=" + params.payment_method_id + "&latitud=" + params.latitud + "&longitud=" + params.longitud + "&criterio=" + res);
        } else {
            url = new URL("http://localhost:4567/agencias?site_id=" + params.site_id + "&payment_method_id=" + params.payment_method_id + "&latitud=" + params.latitud + "&longitud=" + params.longitud + "&criterio=" + res + "&limite=" + params.limite);
        }
        def connection = (HttpURLConnection) url.openConnection()
        connection.setRequestMethod("GET")
        connection.setRequestProperty("Accept", "application/json")
        connection.setRequestProperty("User-Agent", "Mozilla/5.0")
        JsonSlurper json = new JsonSlurper()
        def agencias = json.parse(connection.getInputStream())
        render agencias as JSON

    }

    def persistirAgencia() {
        def jsonSlurper = new JsonSlurper()
        def agenciaJson = jsonSlurper.parseText(params.respuesta)
        def algo = agenciaJson.address.address_line
        def agencia = new Agency(agenciaJson.address.address_line, agenciaJson.address.city, agenciaJson.address.country
                , agenciaJson.address.location, agenciaJson.address.other_info, agenciaJson.address.state, agenciaJson.address.zip_code
                , agenciaJson.agency_code, agenciaJson.description, agenciaJson.disabled
                , agenciaJson.distance, agenciaJson.id, agenciaJson.payment_method_id, agenciaJson.phone, agenciaJson.site_id, agenciaJson.terminal)
        agencia.save()

    }

    def eliminarAgencia() {
        def respuesta;
        if (Agency.findByAgency_code(params.respuesta) != null) {
            def agencia = Agency.findByAgency_code(params.respuesta)
            agencia.delete(flush: true)
            respuesta = "Se borró exitosamente"

        } else {
            respuesta = "No exsite en BD"
        }
        render respuesta

    }

    def verDB() {
        def agencias = Agency.list()
        render(view: "tabla", model: [agencias: agencias])
    }
}
