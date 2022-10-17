# This is used for creating the mhillerstrom/thesis image

FROM qmcgaw/latexdevcontainer
ARG USERNAME=vscode
USER root
RUN tlmgr update --self && \
    tlmgr install latexindent latexmk && \
    tlmgr install mathexam setspace adjustbox xkeyval collectbox enumitem lastpage xkeyval && \
    texhash && \
    apt-get install -y gawk

# Make sure the user $USERNAME exists
RUN adduser --disabled-password -u 501 ${USERNAME} -ingroup users && \
    mkdir -p /home/${USERNAME} && \
    chown -R ${USERNAME}:users /home/${USERNAME}

USER ${USERNAME}