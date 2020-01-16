### Crawling
1.using Zmap to save ips(listening to port 443) in csv format
```sh
$ apt install zmap
$ zmap --bandwidth=10M --target-port=443 --max-targets=1000 --output-file=ips.csv
```

2 download the certificate into a target folder

```sh
$ python src/certificate_download.py ips.txt(filepath) target_folder(folder name)
```

### Parsing
```sh
$ python src/certs_parse.py pem_folder(folder name)
```
The results will be saved into corpus.csv and corpus_extension.csv.The structure of extension table is:

```sh
 pem name, extention_id(No.),extension_critical(bool),extension_name(string),extension_data
```

### Create self-signed CA 
modify the content of v3_req in the openssl.cnf(if adding any v3 extensions)
```sh
 $ openssl genrsa -out ca.key 2048
 $ openssl req -x509 -new -nodes -key ca.key -days 1024 -out tmpCA.pem -extensions v3_req -config openssl.cnf
 $ cat ca.key > rootCA.pem
 $ cat tmpCA.pem > rootCA.pem
```

