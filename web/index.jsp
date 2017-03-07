<!DOCTYPE html>
<html>
    <head>
        <title>Test ComboBox Angular</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.4.8/angular.min.js"></script>
    </head>
    <body ng-app="app" ng-controller="publicar" ng-init="init()" ng-cloak>
        <div>Probando cargar un combo desde angular</div>
        <label>Pais Seleccionado:</label>
        <select ng-model="paisSeleccionado" ng-options="pais as pais.nombre for pais in arrPaises">
        </select>
        
        <br>
        ARRAY DE PAISES:{{arrPaises}}<br>
        
        SELECCIONADO:{{paisSeleccionado}}
        <br>
    </body>
    <script>
    app = angular.module('app',[]).run(function($rootScope,$interval) 
    {});
    app.controller('publicar', function($scope, $rootScope) 
    {
        $scope.init = function()
        {
            $scope.findPaises();
        }
        $scope.findPaises = function()
        {
            $.ajax(
            {
                url:"paises.jsp",
                success: function (resultado, textStatus, jqXHR) 
                {
                    //POPULO TODO EL ARRAY:
                    $scope.arrPaises = JSON.parse(resultado);
                    
                    //BUSCO EN EL ARRAY EL PAIS SELECCIONADO:
                    paisSeleccionadoAux = $scope.findPaisSeleccionado();
                    for( i = 0 ; i < $scope.arrPaises.length ; i++)
                    {
                        paisBucle = $scope.arrPaises[i]
                        if(paisSeleccionadoAux.id == paisBucle.id)
                        {
                            $scope.paisSeleccionado = $scope.arrPaises[i];
                            break;
                        }
                    }
                    
                    $scope.$apply();
                }
            });
        }
        $scope.findPaisSeleccionado = function()
        {
            seleccionado = null;
            $.ajax(
            {
                url:"paisSeleccionado.jsp",
                async: false,
                success: function (resultado, textStatus, jqXHR) 
                {
                    seleccionado = resultado;
                }
            });
            
            return JSON.parse(seleccionado);
        }
    });
    </script>
</html>
