FROM jun-py-env:1.0

ENV ARGV=""

COPY requirements.txt .
COPY formatter.sh .

RUN pip3 install --user --no-cache-dir -r requirements.txt

CMD [ "/bin/bash", "-c", "${HOME}/formatter.sh ${ARGV}" ]
