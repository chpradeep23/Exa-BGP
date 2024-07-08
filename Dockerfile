FROM ubuntu:20.04

# Installing dependencies
COPY Exa-BGP.cfg .
RUN apt update
RUN apt install python3-pip net-tools wget mrtparse vim nano -y && \
    rm -rf /var/lib/apt/lists/* && apt clean
RUN pip install exabgp==4.2.17

# Download latest version of Internet Routing table and delete when complete
RUN wget https://data.ris.ripe.net/rrc16/latest-bview.gz
RUN mrt2exabgp -G -P -4 192.168.0.1 latest-bview.gz > fullbgptable.py
RUN sed -i -E "s/(next-hop ).+( nlri)/\1self\2/g" fullbgptable.py
RUN rm -rf latest-bview.gz
