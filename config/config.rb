SUNAT.configure do |config|
  config.credentials do |c|


    c.ruc       = "20100105609"
    c.username  = "FACTURA2"
    c.password  = "20100105609"
   end

  config.signature do |s|
    s.party_id    = "20100105609"
    s.party_name  = "MADUEÑO S.A.C."
    s.cert_file   = File.join(Dir.pwd, './app/keys', 'certificate2019.crt')
    s.pk_file     = File.join(Dir.pwd, './app/keys', 'CERTIFICADO2019.key') 
  end

  config.supplier do |s|
    s.legal_name = "MADUENO S.A.C."
    s.name       = "GLEN DYER"
    s.ruc        = "20100105609"
    s.address_id = "150118"
    s.street     = "AV.REDUCTO 1548"
    s.district   = "MIRAFLORES"
    s.city       = "LIMA"
    s.country    = "PE"
    s.logo_path  = "#{Dir.pwd}/app/assets/images/logo2.jpg"
  end
end