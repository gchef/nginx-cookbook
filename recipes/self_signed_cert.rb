directory node[:nginx][:ssl_self_signed][:path] do
  action :create
end

node[:nginx][:ssl_self_signed][:subject] = {}
node[:nginx][:ssl_self_signed][:valid_days]

ruby_block 'generate self-signed cert' do
  block do
    require 'openssl'
    require 'securerandom'

    subject_attr_mapping = {
     common_name: 'CN', country: 'C', state: 'ST', city: 'L', organization: 'O',
     department: 'OU', email: 'emailAddress'
    }

    def build_subject(options)
      subject = ''
      options.each_pair do |attr, val|
        subject += "/#{subject_attr_mapping[attr]}=#{val}" if subject_attr_mapping.has_key?(attr)
      end
      subject
    end

    def generate_self_signed_certificate_and_key(subject)
      key = OpenSSL::PKey::RSA.new 2048
      certificate = OpenSSL::X509::Certificate.new
      certificate.version = 2 # X509 v3
      certificate.serial = SecureRandom.random_number(32767)
      certificate.not_before = Time.now
      certificate.not_after = certificate.not_before + (node[:nginx][:ssl_self_signed][:valid_days] * 24*60*60)
      certificate.public_key = key.public_key
      certificate.subject = OpenSSL::X509::Name.parse build_subject(subject)
      certificate.sign(key, OpenSSL::Digest::SHA256.new)
      [certificate, key]
    end

    def write_certificate_and_key_to_disk(c, k)
      ssl_path = node[:nginx][:ssl_self_signed][:path]
      ::File.open("#{ssl_path}/#{node[:nginx][:ssl_self_signed][:cert]}") {|f|
        f.write c.to_pem # write cert to specified path and filename
      }
      ::File.open("#{ssl_path}/#{node[:nginx][:ssl_self_signed][:key]}" {|f|
        f.write k.to_pem # write private key to specified path and filename
      }
    end

    cert, key = generate_self_signed_certificate_and_key(node[:nginx][:ssl_self_signed][:subject])
    write_certificate_and_key_to_disk(cert, key)
  end
  not_if do
    (::File.exists?("#{node[:nginx][:ssl_self_signed][:path]}/#{node[:nginx][:ssl_self_signed][:cert]}") and
     ::File.exists?("#{node[:nginx][:ssl_self_signed][:path]}/#{node[:nginx][:ssl_self_signed][:key]}"))
  end
end
