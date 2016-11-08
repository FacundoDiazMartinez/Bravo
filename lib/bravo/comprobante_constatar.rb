module Bravo
  class ComprobanteConstatar
    attr_reader :client
    attr_accessor :body
  
    def initialize(attrs = {})
      Bravo::AuthData.fetch('constatar')
      namespaces = {
        "xmlns" => "http://servicios1.afip.gob.ar/wscdc/"
        }
      @client         = Savon.client(
        wsdl:  Bravo.service_url,
        namespaces: namespaces,
        log_level:  :debug,
        ssl_cert_key_file: Bravo.pkey,
        ssl_cert_file: Bravo.cert,
        ssl_verify_mode: :none,
        read_timeout: 90,
        open_timeout: 90,
        headers: { "Accept-Encoding" => "gzip, deflate", "Connection" => "Keep-Alive" }
      )
      @body = {"Auth" => Bravo.auth_hash}

    end
    
    def set_body
      data_fields = {"CmpReq" => {"CbteModo" => "CAI", "CuitEmisor" => "20315487898", "PtoVta" => 4002, "CbteTipo" => 1, "CbteNro" => 109, "CbteFch" => "20131227", "ImpTotal" => "121.0" , "CodAutorizacion" => "63523178385550", "DocTipoReceptor" => 80, "DocNroReceptor" => "30628789661"}}
      body.merge!(data_fields)
      return body
    end
    def comprobante_constatar
      body = set_body
      response = client.call :comprobante_constatar do
        message(body)
      end
      return response
    end
    
    def comprobantes_modalidad_consultar
      response = client.call :comprobantes_modalidad_consultar do
        message({"Auth" => Bravo.auth_hash})
      end
      return response
    end
  end
end
