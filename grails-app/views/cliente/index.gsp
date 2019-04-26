<%--
  Created by IntelliJ IDEA.
  User: rluna
  Date: 2019-04-26
  Time: 09:16
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Agencias</title>
    <asset:javascript src="application.js"/>
    <asset:stylesheet src="application.css"/>
</head>

<body>
<g:form name="Formulario" >
    <br><input type="text" id="site_id" placeholder="Sitio ID"></br>
    <br><input type="text" id="payment_method_id" placeholder="Metodo de pago"></br>
    <br><input type="text" id="latitud" placeholder="Latitud"></br>
    <br><input type="text" id="longitud" placeholder="Longitud"></br>
    <br>
    <select name="selector">
        <option value="1">Address Line</option>
        <option value="2">Agency Code</option>
        <option value="3">Distance</option>
    </select>
    </br>
    <br><button type="button"  onclick ="getAgencias()">Cargar datos</button>
</g:form>
<script>
    function getAgencias() {
        $("#tabla tr").remove();
        $("<table id=tabla class=table>").appendTo('#div1');
        $("#tabla").append("<thead>\n" +
            "            <tr>\n" +
            "              <th >Codigo agencia</th>\n" +
            "              <th >Nombre</th>\n" +
            "              <th >Direcion</th>\n" +
            "              <th >Ciudad</th>\n" +
            "              <th >Persistir</th>\n" +
            "            </tr>\n" +
            "          </thead>");
        var URL = "${createLink(controller:'cliente',action:'cargaDatos')}";

        $.ajax({
            url: URL,
            data: {site_id: $('#site_id').val(),
                payment_method_id:$('#payment_method_id').val(),
                latitud:$('#latitud').val(),
                longitud:$('#longitud').val(),
                criterio:$('select[name=selector]').val()},
                success: function (resp) {
                    Object.keys(resp.data).forEach(function (k) {
                        $("#tabla").append("<tr id=" +resp.data[k].agency_code+ ">" +
                            "<td>" + resp.data[k].agency_code + "</td>" +
                            "<td>" + resp.data[k].description + "</td>" +
                            "<td>" + resp.data[k].address.address_line + "</td>" +
                            "<td>" + resp.data[k].address.city + "</td>" +
                            "<td><button type=\"button\" id=" +resp.data[k].agency_code+">Guardar</button>" +
                            "<button type=\"button\" id=E" +resp.data[k].agency_code+">Eliminar</button> </td>" +
                            "</tr>");
                        $('#'+resp.data[k].agency_code).click(function(){
                            persistir(resp.data[k])
                        });
                        $('#E'+resp.data[k].agency_code).click(function(){
                            eliminar(resp.data[k].agency_code)
                        })
                    });

            },

        });
    }
    
    function persistir(respuesta) {
        var json= JSON.stringify( respuesta);
        var URL = "${createLink(controller:'cliente',action:'persistirAgencia')}";
        $.ajax({
            url: URL,
            data: {respuesta: json},
            success: function (resp) {
                alert("Se guardo correctamente")
            },
        });
    }
    function eliminar(respuesta) {
        var URL = "${createLink(controller:'cliente',action:'eliminarAgencia')}";
        $.ajax({
            url: URL,
            data: {respuesta: respuesta},
            success: function (resp) {
                alert("Se eliminó correctamente")
            },
        });
    }
</script>
<div id="div1" class="table-responsive">


</div>
</body>
</html>