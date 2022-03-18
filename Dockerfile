# Builds a considerably smaller image 
FROM python:3.9.5-slim-buster 

# # set work directory 

# COPY ./app /app 

# set env variables 

ENV PYTHONDONTWRITEBYTECODE 1 
ENV PYTHONNUNBUFFERED 1 
# ENV PORT 8008
ENV PATH="$PATH:$HOME/.poetry/bin"




WORKDIR /app 


# install poetry 

RUN pip3 install poetry 

# install dependencies 
COPY pyproject.toml poetry.lock ./ 
RUN poetry install --no-root --no-dev 

#copy project 
COPY . . 
RUN poetry install --no-dev 

EXPOSE 8000:8008

# COPY ./requirements.txt /code/requirements.txt 

# RUN pip install --upgrade pip 

# RUN pip install --no-cache-dir --upgrade -r /code/requirements.txt 

# COPY . /app

# EXPOSE 8008:8008 





# command to run on container start 

CMD ["poetry","run","uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000" ]