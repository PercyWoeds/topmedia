
SUNAT.configure do |config|
  config.credentials do |c|


    c.ruc       = "20546833594"
    c.username  = "GEYE2018"
    c.password  = "20546833594"
   end

  config.signature do |s|
    s.party_id    = "20546833594"
    s.party_name  = "TOP MEDIA S.A.C."
     s.cert_file   = File.join(Dir.pwd, './app/keys', 'certificate2019.crt')
    s.pk_file     = File.join(Dir.pwd, './app/keys', 'CERTIFICADO2019.key') 
  end

  config.supplier do |s|
    s.legal_name = "TOP MEDIA S.A.C."
    s.name       = ""
    s.ruc        = "20546833594"
    s.address_id = "150118"
    s.street     = "AV. REDUCTO NRO. 1548 URB. SAN ANTONIO"
    s.district   = "MIRAFLORES - LIMA - LIMA   "
    #s.city       = "LOCAL: AV. CERRO DE PASCO NRO. 253 (A DOS CDAS DEL MUNICIPIO)
    #PASCO - PASCO - PAUCARTAMBO"
    s.city       = ""
    s.country    = "PE"
    s.logo_path  = "#{Dir.pwd}/app/assets/images/logo.png"

                          
                          
  end
end

