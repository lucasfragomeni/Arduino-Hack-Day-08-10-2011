import processing.serial.*;
import processing.net.*;
import cc.bebop.*;

//Servidor WEB
Server server;

//Porta Serial - Arduino
Serial arduino;

void setup()
{
  size(200, 100);
  background(255);

  //Inicializa o servidor web na porta 8080
  server = new Server(this, 8080);

  //Lista as portas seriais disponíveis
  println(Serial.list());

  //Inicializa a comunicação com a Arduino. Parâmetros:
  //- 'this': padrão;
  //- 'Serial.list()[0]': primeira porta serial encontrada;
  //- '9600': velocidade da comunicação serial
  arduino = new Serial(this, Serial.list()[0], 9600);
}

void draw() {
  //Aguarda um cliente web
  Client client = server.available();
  if(client != null) {

    //Pega a requisição HTTP
    String requestStr = client.readString();
    HTTPRequest request = new HTTPRequest(requestStr);

    //Obtém o parâmetro 'estado' da requisição
    String estado = request.getParameter("estado");
    println("Estado: " + estado);
    
    if(estado != null) {
      //Envia o comando para a Arduino
      arduino.write(new byte[] {Byte.parseByte(estado)});
    }

    //Monta a página para retornar  
    String pagina = montarPagina(estado);

    //Escreve a página para o browser e desconecta    
    server.write(pagina);
    server.disconnect(client);
  }
}

String montarPagina(String estado) {
  //Se houver um 'estado', então inverte seu valor para montar a página
  if(estado != null) {
    //Se 'ligado': assume o valor 'desligado'
    if(estado.equals("1")) {
      estado = "0";
    }
    //Se não, assume 'ligado'
    else {
      estado = "1";
    }
  }
  //Se não houver, então assume 'ligado'
  else if(estado == null) {
    estado = "1";
  }

  String html = "<html><body><table width='100%' height='100%'>";
  html += "<tr width='100%' height='100%' valign='middle' align='center'><td width='100%' height='100%'>";
  html += "<form method=\"GET\"><input type='hidden' name='estado' value='" + estado + "'/>";
  html += "<input type='submit' value='" + (estado.equals("1") ? "On" : "Off") + "' style='font:20px;width:100px;height:50px;'/></form>";
  html += "</td></tr></table></body></html>";
  
  return html;
}
