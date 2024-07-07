FROM ubuntu:22.04

# Install dependencies
COPY Exa-BGP.cfg .
RUN apt update
RUN apt install python3-pip net-tools wget mrtparse vim nano -y && \
    rm -rf /var/lib/apt/lists/* && apt clean
RUN pip install exabgp==4.2.22

# Download latest table and remove when complete
RUN wget https://data.ris.ripe.net/rrc16/latest-bview.gz
RUN mrt2exabgp -G -P -4 172.16.2.1 latest-bview.gz > fullbgptable.py
RUN rm -rf latest-bview.gz