<%--
  Created by IntelliJ IDEA.
  User: rluna
  Date: 2019-04-27
  Time: 15:27
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <asset:stylesheet src="application.css"/>
    <title></title>
</head>

<body>
<div id="div2" class="table-responsive">
    <table class="table">
        <thead>
        <tr>
            <th>Id</th>
            <th>address_line</th>
            <th>city</th>
            <th>country</th>
            <th>location</th>
            <th>other_info</th>
            <th>state</th>
            <th>zip_code</th>
            <th>agency_code</th>
            <th>description</th>
            <th>disabled</th>
            <th>distance</th>
            <th>payment_method_id</th>
            <th>phone</th>
            <th>site_id</th>
            <th>terminal</th>
        </tr>
        </thead>
        <g:each in="${agencias}">
            <tr>
                <td>${it.getId()}</td>
                <td>${it.getAddress_line()}</td>
                <td>${it.getCity()}</td>
                <td>${it.getCountry()}</td>
                <td>${it.getLocation()}</td>
                <td>${it.getOther_info()}</td>
                <td>${it.getState()}</td>
                <td>${it.getZip_code()}</td>
                <td>${it.getAgency_code()}</td>
                <td>${it.getDescription()}</td>
                <td>${it.getDisabled()}</td>
                <td>${it.getDistance()}</td>
                <td>${it.getPayment_method_id()}</td>
                <td>${it.getPhone()}</td>
                <td>${it.getSite_id()}</td>
                <td>${it.getTerminal()}</td>

            </tr>
        </g:each>

    </table>
</div>

</body>
</html>