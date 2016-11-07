module Bravo
  class ComprobanteConstatar
  
    def initialize(attrs = {})
      Bravo::AuthData.fetch
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

      @body           = {"Auth" => Bravo.auth_hash}

    end
    
    def set_body
      content = {"CmpReq" =>{cbte_modo: "CAE", cuit_emisor: "20267565393", pto_vta: 4002, cbte_tipo: 1, cbte_nro: 109, cbte_fch: "20131227", imp_total: "121.0" , cod_autorizacion: "63523178385550", doc_tipo_receptor: 80, doc_nro_receptor: "30628789661"}}
      @body.merge! content
    end
    
    def call_function
      set_body
      response = client.call :comprobante_constatar do
        message(@body)
      end
      return response
    end
  end
end
