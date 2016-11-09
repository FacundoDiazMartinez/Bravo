module Bravo
  class ComprobanteConstatar
    attr_reader :client
    attr_accessor :body, :cbte_modo, :cuit_emisor, :pto_vta, :cbte_tipo, :cbte_nro,
                  :cbte_fch, :imp_total, :cod_autorizacion, :doc_tipo_receptor, :doc_nro_receptor
    
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
      self.cbte_modo          = attrs[:cbte_modo].to_s
      self.cuit_emisor        = attrs[:cuit_emisor].to_s
      self.pto_vta            = attrs[:pto_vta]
      self.cbte_tipo          = attrs[:cbte_tipo]
      self.cbte_nro           = attrs[:cbte_nro]
      self.cbte_fch           = attrs[:cbte_fch].strftime("%Y%m%d")
      self.imp_total          = attrs[:imp_total].to_f.to_s
      self.cod_autorizacion   = attrs[:cod_autorizacion].to_s
      self.doc_tipo_receptor  = attrs[:doc_tipo_receptor]
      self.doc_nro_receptor   = attrs[:doc_nro_receptor].to_s

    end
    
    def set_body
      data_fields = {
          "CmpReq" => {
              "CbteModo" => cbte_modo,
              "CuitEmisor" => cuit_emisor,
              "PtoVta" => pto_vta,
              "CbteTipo" => cbte_tipo,
              "CbteNro" => cbte_nro,
              "CbteFch" => cbte_fch,
              "ImpTotal" => imp_total ,
              "CodAutorizacion" => cod_autorizacion,
              "DocTipoReceptor" => doc_tipo_receptor,
              "DocNroReceptor" => doc_nro_receptor
            }
       }
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
