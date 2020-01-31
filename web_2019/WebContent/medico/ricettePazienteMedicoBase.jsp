<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html5>
<html lang="it">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Ricette</title>
<link rel="stylesheet" href="../css/custom.css">
<link rel="stylesheet" href="../css/tempusdominus-bootstrap-4.min.css">
<link rel="stylesheet" href="../css/fontawesome-pro-5.12.0-web/css/all.css">
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/dataTables.bootstrap4.min.css">
<script src="../js/popper.min.js"></script>
<script src="../js/jquery-3.3.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/datatables.min.js"></script>
<script src="../js/jquery.dataTables.js"></script>
<script src="../js/dataTables.bootstrap4.min.js"></script>
<script src="../js/moment-with-locales.min.js"></script>
<script src="../js/tempusdominus-bootstrap-4.min.js"></script>
<script src="../js/qrcode.js"></script>
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-lg navbar-dark"><a class="navbar-brand" href="#"></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"> <span class="navbar-toggler-icon"></span> </button>
  <div class="collapse navbar-collapse" id="navbarSupportedContent">
    <ul class="navbar-nav mr-auto">
      <li class="nav-item"> <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a> </li>
      <li class="nav-item active"> <a class="nav-link " href="#" role="button" aria-haspopup="true" aria-expanded="false"> Pazienti </a> </li>
      <li class="nav-item"><a class="nav-link" href="#" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false"> Visite <span class="badge badge-pill badge-warning">2</span></a> </li>
      <li class="nav-item d-inline-block align-bottom"><img alt="iconaUtente" class="img iconaUtente rounded-circle " src="../images/utente1img.jpg"></li>
      <li class="nav-item"> <a class="btn btn-danger  " href="#">Logout</a> </li>
    </ul>
  </div>
</nav>
&nbsp;
<div class="container text-center" style="background-color: #C1D4D9; border-radius: 20px; padding:20px; max-width: 70%"><img class="rounded-circle " src="../images/utente1img.jpg" width="150" height="150" alt="user" style="margin-bottom: 10px;">
  <h2>Ricette di: <span class="badge badge-info">${visita_corrente.paziente.nome} ${visita_corrente.paziente.cognome}</span></h2>
  <form id="formPaziente${visita_corrente.paziente.id}" action="DettagliPaziente">  
       <input type="hidden" value="${visita_corrente.paziente.id}" name="id"> 
  <button class="btn btn-success" type="submit"><i class="fa fa-arrow-circle-left" style="vertical-align: middel"></i> Torna al paziente</button>
  </form>
</div>
&nbsp;
<hr>
<div class="text-center container" style="background-color: #C1D4D9;  border-radius: 20px; padding: 20px; margin-bottom: 20px;">
  <div class="bg-light" style=" border-radius:20px; padding: 10px;">
    
    &nbsp;
    <div class="container">
      <table id="tabellaRicette" class="table datatable table-striped table-hover table-light tabella_visite" style="width: 100%;">
        <thead>
          <tr>
            <th>Medico prescrittore</th>
            <th>Stato</th>
            <th>Data prescrizione/erogazione</th>
            <th></th>
          </tr>
        </thead>
        <tbody>
        <c:forEach items="${visita_corrente.paziente.listaPrescrizioni}" var="prescrizione">
          <tr>
            <td>${prescrizione.nome_medico}</td>
            <c:if test="${prescrizione.stato==0}">
            <td style="vertical-align: middle"><span class="badge badge-pill badge-info">Non erogata</span></td>
            </c:if>
            <c:if test="${prescrizione.stato==1}">
            <td style="vertical-align: middle"><span class="badge badge-pill badge-secondary">Erogata</span></td>
            </c:if>
            <td style="vertical-align: middle">${prescrizione.data}</td>
            <c:if test="${prescrizione.stato==0}">
            <td style="vertical-align: middle"><a href="#" onclick="modal_ricetta_da_erogare(${prescrizione.id_prescrizione})" class="btn btn-outline-info"><i class="fa fa-info-circle"></i> Dettagli</a></td>
            </c:if>
             <c:if test="${prescrizione.stato!=0}">
            <td style="vertical-align: middle"><a href="#" onclick="modal_ricetta_erogata(${prescrizione.id_prescrizione})" class="btn btn-outline-info"><i class="fa fa-info-circle"></i> Dettagli</a></td>
            </c:if>
          </tr>
         </c:forEach>
        </tbody>
      </table>
      <hr>
      <h5>Per prescrivere una nuova ricetta compila una visita: </h5>
      <br>
      <form id="formVisite" action="VisitePaziente">  
       <input type="hidden" value="${visita_corrente.paziente.id}" name="id"> 
      <button href="#" type="submit" class="btn btn-success"><i class="fa fa-arrow-circle-right" style=" font-size: 20px; vertical-align: middle; padding: 5px 5px"></i> Vai alle visite del paziente</button>
    </form>
    </div>
  </div>
</div>
&nbsp;
<div class="modal fade" id="modalRicettaErogata">
  
	<div class="modal-dialog">
    <div class="modal-content"> 
      
      <!-- Modal Header -->
      <div class="modal-header text-light" style="background-color: #205373">
        <h4 class="modal-title">Dettagli ricetta erogata</h4>
        <button type="button" class="close text-light" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body" style="background-color:  #C1D4D9">
         <div class="container  bg-light text-center" style="padding: 10px;border-radius: 20px; margin-bottom: 20px;">
          <h5>
            <p class="badge badge-info">Medico prescrittore</p>
          </h5>
          <h5 id="nome_medico_erogata"></h5>
          <hr class="bg-light">
          <h5>
            <p class="badge badge-info">Data prescrizione</p>
          </h5>
          <h5 id="data_erogata"></h5>
          <hr class="bg-light">
          <h5>
            <p class="badge badge-info">Visita di riferimento</p>
          </h5>
         <h5 id="visita_riferimento_erogata"></h5>
          <hr class="bg-light">
          <h5>
            <p class="badge badge-info">Farmacia erogatrice</p>
          </h5>
         <h5 id="farmacia_erogata"></h5>
          <hr class="bg-light">
          <h5>
            <p class="badge badge-info">Prescrizione</p>
          </h5>
          <p id="farmaco_erogata" class="card-body text-left" style="border-style: solid; border-radius: 20px;"></p>
          <hr class="bg-light">
          <h5>
            <p class="badge badge-info">PDF ricetta</p>
          </h5>
          <a href="#" class="btn btn-success">Scarica PDF</a>
          <hr class="bg-light">
          <h5>
            <p class="badge badge-info">Codice QR</p>
          </h5>
          <button class="btn btn-success" data-toggle="collapse" data-target="#collpase_qr_erogata">Mostra QR</button>
          <div id="collpase_qr_erogata" class="collapse text-center" style="margin-top: 20px;"> <div id="qr_erogata" class="text-center container" style="width: 300px; height: 300px;"></div> </div>
        </div>
         </div>
        
        <!-- Modal footer -->
        <div class="modal-footer text-light" style="background-color: #205373">
          <h6 id="codice_footer_erogata" class="badge text-dark badgeNumeroVisitaEsame" style="margin-top:10px;"></h6>
          <button type="button" class="btn btn-danger" data-dismiss="modal">Chiudi</button>
        </div>
      </div>
    </div>
  </div>
</div>

<script>

function modal_ricetta_erogata(id){
	 
	   $.ajax({
	        url: 'http://localhost:8080/web2019/medico/modal/dettagli_ricetta?id_ricetta='+id,
	        type: "GET",
	        success: function (result) { 
	        	console.log(result);
	            document.getElementById('data_erogata').innerHTML=result.data;
	            document.getElementById('nome_medico_erogata').innerHTML=result.nome_medico + " " + result.cognome_medico;    
	            document.getElementById('visita_riferimento_erogata').innerHTML=result.id_riferimento;
	            document.getElementById('farmaco_erogata').innerHTML=result.farmaco;
	            document.getElementById('codice_footer_erogata').innerHTML="Codice ricetta: " + id; 
	            document.getElementById('farmaco_erogata').innerHTML=result.farmaco;
	            document.getElementById('farmacia_erogata').innerHTML=result.farmacia;
	            var qrcode = new QRCode("qr_erogata");

	            function makeCode () {		
	            	var elText = "Ricetta numero: "+ id + ", data prescrizione: " + result.data + ", medico prescrittore: " +
								result.nome_medico + " " + result.cognome_medico + ", prescrizione: "+ result.farmaco + ", farmacia erogatrice: "+ result.farmacia + ".";
	            	
	            	qrcode.makeCode(elText);
	            }

	            makeCode();

	            
	            
	            
	            
	            
	            
	            $('#modalRicettaErogata').modal('show');
	            
	            
	            },
	            
	         error: function (result){
	        	
	        	console.log(result);
	        	
	        	
	        }
	        });
	    
	  
	};



function modal_ricetta_da_erogare(id){
	 
	   $.ajax({
	        url: 'http://localhost:8080/web2019/medico/modal/dettagli_ricetta?id_ricetta='+id,
	        type: "GET",
	        success: function (result) { 
	        	console.log(result);
	            document.getElementById('data_non_erogata').innerHTML=result.data;
	            document.getElementById('nome_medico_non_erogata').innerHTML=result.nome_medico + " " + result.cognome_medico;    
	            document.getElementById('visita_riferimento_non_erogata').innerHTML=result.id_riferimento;
	            document.getElementById('farmaco_non_erogata').innerHTML=result.farmaco;
	            document.getElementById('codice_footer_non_erogata').innerHTML="Codice ricetta: " + id; 
	            
	            
	            var qrcode = new QRCode("qr_non_erogata");

	            function makeCode () {		
	            	var elText = "Ricetta numero: "+ id + ", data prescrizione: " + result.data + ", medico prescrittore: " +
								result.nome_medico + " " + result.cognome_medico + ", prescrizione: "+ result.farmaco + ".";
	            	
	            	qrcode.makeCode(elText);
	            }

	            makeCode();

	            
	            
	            
	            
	            
	            
	            $('#modalRicettaDaErogare').modal('show');
	            
	            
	            },
	            
	         error: function (result){
	        	
	        	console.log(result);
	        	
	        	
	        }
	        });
	    
	  
	};





</script>


<div class="modal fade modalPrenotazione" id="modalRicettaDaErogare">
  <div class="modal-dialog">
    <div class="modal-content"> 
      
      <!-- Modal Header -->
      <div class="modal-header text-light" style="background-color: #205373">
        <h4 class="modal-title">Dettagli ricetta da erogare</h4>
        <button type="button" class="close text-light" data-dismiss="modal">&times;</button>
      </div>
      
      <!-- Modal body -->
      <div class="modal-body" style="background-color:  #C1D4D9">
        <div class="container  bg-light text-center" style="padding: 10px;border-radius: 20px; margin-bottom: 20px;">
          <h5>
            <p class="badge badge-info">Medico prescrittore</p>
          </h5>
          <h5 id="nome_medico_non_erogata"></h5>
          <hr class="bg-light">
          <h5>
            <p class="badge badge-info">Data prescrizione</p>
          </h5>
          <h5 id="data_non_erogata"></h5>
          <hr class="bg-light">
          <h5>
            <p class="badge badge-info">Visita di riferimento</p>
          </h5>
         <h5 id="visita_riferimento_non_erogata"></h5>
          <hr class="bg-light">
          <h5>
            <p class="badge badge-info">Prescrizione</p>
          </h5>
          <p id="farmaco_non_erogata" class="card-body text-left" style="border-style: solid; border-radius: 20px;"></p>
          <hr class="bg-light">
          <h5>
            <p class="badge badge-info">PDF ricetta</p>
          </h5>
          <a href="#" class="btn btn-success">Scarica PDF</a>
          <hr class="bg-light">
          <h5>
            <p class="badge badge-info">Codice QR</p>
          </h5>
          <button class="btn btn-success" data-toggle="collapse" data-target="#collpase_qr_non_erogata">Mostra QR</button>
          <div id="collpase_qr_non_erogata" class="collapse text-center" style="margin-top: 20px;"> <div id="qr_non_erogata" class="text-center container" style="width: 300px; height: 300px;"></div> </div>
        </div>
         </div>
        <!-- Modal footer -->
        <div class="modal-footer text-light" style="background-color: #205373">
          <h6 id="codice_footer_non_erogata" class="badge text-dark badgeNumeroVisitaEsame" style="margin-top:10px;"> </h6>
          <button type="button" class="btn btn-danger" data-dismiss="modal">Chiudi</button>
        </div>
      </div>
    </div>
  </div>
</div>
<footer class="text-center text-light">©2019 Oradini & Bertamini</footer>
<script src="../js/medico_base/utils_ricette_paziente_medico_base.js"></script>
</body>
</html>