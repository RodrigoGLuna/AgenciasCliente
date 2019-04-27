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
    <h1>Buscar agencias</h1>
</head>

<body>
<div>
    <g:form name="Formulario" style="margin-left: 20px;">
        <br><input type="text" id="site_id" placeholder='Sitio ID' required
                   oninput="this.value = this.value.toUpperCase()" onkeypress="return /[a-z]/i.test(event.key)"> </br>
        <br><input type="text" id="payment_method_id" placeholder="Metodo de pago" required></br>
        <br><input type="text" id="latitud" placeholder="Latitud" required></br>
        <br><input type="text" id="longitud" placeholder="Longitud" required></br>
        <br><input type="number" id="limite" placeholder="Limite"></br>
        <br>
        <select name="selector">
            <option value="0">Sin ordenamiento</option>
            <option value="1">Address Line</option>
            <option value="2">Agency Code</option>
            <option value="3">Distance</option>
        </select>
        </br>
        <br><button id="botonCarga" type="button" onclick="validar()">Cargar datos</button>
    </g:form>
</div>

<script>
    function validar() {
        if (document.getElementById('site_id').value == '' || document.getElementById('payment_method_id').value == '' || document.getElementById('latitud').value == '' || document.getElementById('longitud').value == '') {
            alert("Complete los campos requeridos");
        } else if ((document.getElementById('limite').value < 1 || document.getElementById('limite').value > 100) && document.getElementById('limite').value != '') {
            alert("El limite debe ser entre 1 a 100");
        } else {
            getAgencias();
        }
    }

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
            data: {
                site_id: $('#site_id').val(),
                payment_method_id: $('#payment_method_id').val(),
                latitud: $('#latitud').val(),
                longitud: $('#longitud').val(),
                criterio: $('select[name=selector]').val(),
                limite: $('#limite').val()
            },
            success: function (resp) {
                Object.keys(resp.data).forEach(function (k) {
                    $("#tabla").append("<tr id=" + resp.data[k].agency_code + ">" +
                        "<td>" + resp.data[k].agency_code + "</td>" +
                        "<td>" + resp.data[k].description + "</td>" +
                        "<td>" + resp.data[k].address.address_line + "</td>" +
                        "<td>" + resp.data[k].address.city + "</td>" +
                        "<td><button type=\"button\" id=" + resp.data[k].agency_code + " class=\"btn btn-primary\">Guardar</button>" +
                        "<button type=\"button\" id=E" + resp.data[k].agency_code + " class=\"btn btn-danger\">Eliminar</button> </td>" +
                        "</tr>");
                    $('#' + resp.data[k].agency_code).click(function () {
                        persistir(resp.data[k])
                    });
                    $('#E' + resp.data[k].agency_code).click(function () {
                        eliminar(resp.data[k].agency_code)
                    })
                });
                document.getElementById("botonOculto").style.display = "block";
            },

        });
    }

    function persistir(respuesta) {
        var json = JSON.stringify(respuesta);
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
                alert("" + resp)
            },
        });
    }

    function verBaseDato() {
        var URL = "${createLink(controller:'cliente',action:'verDB')}";
        window.location.href = URL;
    }
</script>

<div id="div1" class="table-responsive">

</div>

<button id="botonOculto" type="button" style="margin-top: 20px; display: none;" class="btn btn-info btn-lg"
        onclick="verBaseDato()">Ver Date Base</button>

</body>
</html>