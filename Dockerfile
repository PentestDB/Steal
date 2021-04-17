FROM kalilinux/kali:latest

MAINTAINER https://pentest-db.com

# -------------------------------------

COPY README.md /home

# -------------------------------------

RUN apt-get update && \
    apt-get install -y python2 && \
    #apt-get install -y python-pip && \
    apt-get install -y python3-pip && \
    apt-get install -y python3 && \
    apt-get install -y sqlmap && \
    apt-get install -y vim && \
    apt-get install -y wget && \
    apt-get install -y curl && \
    apt-get install -y nmap && \
    apt-get install -y nikto && \
    apt-get install -y git && \
    apt-get install -y nano && \
    apt-get install -y dnsutils && \
    apt-get install -y iputils-ping && \
    apt-get install -y xprobe2 && \
    apt-get install -y whois && \
    apt-get install -y net-tools && \
    apt-get install -y netcat && \
    apt-get install -y john && \
    apt-get install -y apache2 && \
    apt-get install -y hashcat && \
    apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev && \
    apt-get install -y libcurl4-openssl-dev && \
    apt-get install -y ssh && \
    apt-get install neofetch && \
    apt-get install php   
    # apt-get install -y linux-installer.sh

# Run install & bkh-tdv.py
RUN python3 -m pip install -r requirments.txt && \
    python3 bkh-tdv.py

# start service
RUN systemctl enable ssh
ENTRYPOINT service ssh start && bash
COPY sshd_config /etc/ssh/
ENTRYPOINT service ssh restart && bash
ENTRYPOINT service apache2 start && bash

# reset passwd root

RUN echo "root:bkh474" | chpasswd

# dnsenum
#RUN apt-get install -y build-essential && \
    #chmod +x /home/dnsenum/dnsenum.pl && \
    #ln -s /home/dnsenum/dnsenum.pl /usr/bin/dnsenum && \
    #cpanm String::Random && \
    #cpanm Net::IP && \
    #cpanm Net::DNS && \
    #cpanm Net::Netmask && \
    #cpanm XML::Writer

# digbit
RUN git clone https://github.com/szalek/digbit.git /home/digbit && \
    chmod +x /home/digbit/src/digbit.py && \
    ln -s /home/digbit/src/digbit.sh /usr/bin/digbit && \
    ln -s /home/digbit/src/digbit.py /usr/bin/digbit.py

# Sn1per
RUN git clone https://github.com/szalek/Sn1per.git /home/Sn1per/ && \
    chmod +x /home/Sn1per/install.sh && \
    cd /home/Sn1per/ && \
    /bin/bash install.sh

# webcomment
RUN git clone https://github.com/szalek/webcomment.git /home/webcomment && \
    chmod +x /home/webcomment/webcomment.py && \
    ln -s /home/webcomment/webcomment.py /usr/bin/webcomment


# haveibeenpwned
RUN git clone https://github.com/szalek/haveibeenpwned.git /home/haveibeenpwned && \
    chmod +x /home/haveibeenpwned/haveibeenpwned.sh && \
    ln -s /home/haveibeenpwned/haveibeenpwned.sh /usr/bin/haveibeenpwned

# exploit-database
RUN git clone https://github.com/offensive-security/exploit-database.git /opt/exploit-database && \
    ln -sf /opt/exploit-database/searchsploit /usr/local/bin/searchsploit

# wpscan
RUN apt-get install -y libcurl4-openssl-dev libxml2 libxml2-dev libxslt1-dev ruby-dev build-essential libgmp-dev zlib1g-dev && \
    git clone https://github.com/wpscanteam/wpscan.git && \
    cd wpscan && \
    gem install bundler && bundle install --without test && \
    ln -sf /home/wpscan/wpscan.rb /usr/local/bin/wpscan

# passwords
RUN cd /home && \
    git clone https://github.com/szalek/get_passwords.git && \
    cd /home/get_passwords && \
    chmod +x get_passwords.sh && \
    ln -sf /home/get_passwords/get_passwords.sh /usr/local/bin/get_passwords

# Sublist3r
RUN cd /home && \
    git clone https://github.com/aboul3la/Sublist3r && \
    cd /home/Sublist3r && \
    pip install -r requirements.txt && \
    ln -sf /home/Sublist3r/sublist3r.py /usr/local/bin/sublist3r

# massdns
RUN cd /home && \
    git clone https://github.com/blechschmidt/massdns.git && \
    cd /home/massdns && \
    make && \
    ln -sf /home/massdns/bin/massdns /usr/local/bin/massdns

# xsssniper
RUN cd /home && \
    #apt-get install -y python-pip && \
    #pip install mechanize && \
    #pip install lxml && \
    git clone https://github.com/gbrindisi/xsssniper.git && \
    cd /home/xsssniper && \
    ln -sf /home/xsssniper/xsssniper.py /usr/local/bin/xsssniper

# arachni
RUN wget https://github.com/Arachni/arachni/releases/download/v1.5.1/arachni-1.5.1-0.5.12-linux-x86_64.tar.gz && \
        tar xzvf arachni-1.5.1-0.5.12-linux-x86_64.tar.gz > /dev/null && \
        mv arachni-1.5.1-0.5.12 /usr/local && \
        ln -s /usr/local/arachni-1.5.1-0.5.12/bin/* /usr/local/bin/