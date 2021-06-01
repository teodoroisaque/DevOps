#Para usar o terraform tenho o costume de usar rodando um container em meu note.
#Uso a distro alpine e faço a instalação do aws cli direto na imagem, para deixar cadastrado a AWS_KEY e AWS_ID
#Faço o mapeamento do volume para alterar os arquivos no VSCode
# docker run -itd --name terraform -v $PWD:/app --entrypoint "" terraform sh

FROM hashicorp/terraform:light

RUN apk add --no-cache python3 py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install awscli \
    && rm -rf /var/cache/apk/*

WORKDIR /app