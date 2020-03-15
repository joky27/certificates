#! /bin/bash


ca_file=""#CA file pem format
result_dir=""#the folder to record results


root_ca_file=''
leaf_file=''
openssl_instrumented_src='../openssl-1.1.1c'
openssl_instrumented_bin='../bin/openssl'
polarssl_instrumented_bin='../mbedtls-2.16.2/programs/x509/cert_app'
gnutls_instrumented_bin='../gnutls/bin/certtool'
matrixssl_instrumended_bin='../matrixssl/test/certValidate'
file=''


result_file=$result_dir${file%.*}".txt"
echo '-----START VERIFYING '$file >>$result_file

if [ ! -f "$root_ca_file" ];then
      $openssl_instrumented_bin  verify -CAfile $ca_file $file >>$result_file 2>>$result_file
else
      $openssl_instrumented_bin  verify -CAfile $root_ca_file $leaf_file >>$result_file 2>>$result_file
fi
echo '-----END VERIFYING '$file>>$result_file
echo "---complete openssl verification"


result_file=$result_dir${file%.*}"_polarssl.txt"
echo '-----START VERIFYING '$file >>$result_file
$polarssl_instrumented_bin mode='file' filename=$file ca_file=$ca_file >>$result_file 2>>$result_file
echo '-----END VERIFYING '$file>>$result_file
echo ' '>>$result_file
echo "---complete polarssl verification"

result_file=$result_dir${file%.*}"_gnutls.txt"
echo '-----START VERIFYING '$file >>$result_file
$gnutls_instrumented_bin --verify --load_ca_certificate=$ca_file <$file >>$result_file 2>>$result_file
echo '-----END VERIFYING '$file>>$result_file
echo ' '>>$result_file
echo "---complete gnutls verification"