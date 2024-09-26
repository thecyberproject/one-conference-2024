# GoPhish

For the phishin attack the use: [GoPish](https://github.com/gophish/gophish) and Open-Source Phishing Toolkit

Gophish is an open-source phishing toolkit designed for businesses and penetration testers. It provides the ability to quickly and easily setup and execute phishing engagements and security awareness training.

## Setting up GoPhish

```bash
wget https://github.com/gophish/gophish/releases/download/v0.12.1/gophish-v0.12.1-linux-64bit.zip
unzip
openssl req -newkey rsa:2048 -nodes -keyout gophish.key -x509 -days 365 -out gophish.crt
sed -i 's/"127.0.0.1:3333"/"0.0.0.0:3333"/' config.json 
sudo chmod +x gophish
sudo ./gophish 
echo "Optionally you can use"
screen -S gophish
```

You can also run gophish as a service as described [here](https://github.com/gophish/gophish/issues/586), but for the scenario running it as a process should be fine. 
Now the admin portal runs on port `3333`. Next, we can import the `template.html` located in this repository. The template can be loaded under `Email Templates`.
