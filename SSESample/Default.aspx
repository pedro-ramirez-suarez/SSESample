<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="SSESample._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="jumbotron">
        <h1>SSE on ASP.NET</h1>
        <p class="lead">
            Server Sent Events is a technology that allows a web application to receive updates from the server via HTTP automatically without constatly checking the server.
        <br />
            This means that the server is not going to be receiving constant requests just to check if there is new data.
        </p>
        <p><a href="http://www.w3.org/TR/eventsource/" class="btn btn-primary btn-large" target="_blank">Learn more &raquo;</a></p>
    </div>

    <div class="row">
        <div class="col-md-4">
            <a class="btn btn-default" id="btnListen" onclick="startConnection()">Start connection</a>
            <div id="state"></div>
        </div>

        <div class="col-md-8">
            <div class="row" id="results">
            </div>
        </div>
    </div>

    <script>

        function startConnection() {

            var source = new EventSource('SSEHandler.cspx');
            source.addEventListener("open", function (event) {
                $('#state').html('<b>Connection Open</b>');
            }, false);

            source.addEventListener("error", function (event) {
                if (event.eventPhase == EventSource.CLOSED) {
                    $('#state').append('<b>Connection Closed</b>');
                }
            }, false);

            source.addEventListener("message", function (event) {
                var color = JSON.parse(event.data);
                $('#results').append('<div class="col-md-1" style=" background-color: rgb(' + color.r + ',' + color.g + ',' + color.b + ');">&nbsp;</div>');

            }, false);

        }


    </script>

</asp:Content>
