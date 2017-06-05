import os

from setuptools import setup

def read(fname):
    return open(os.path.join(os.path.dirname(__file__), fname)).read()

setup(
    name = 'MySQL_RabbitMQ_replicator',
    version='0.1',
    description='A MySQL replication service using RabbitMQ',
    long_description=read('README'),
    url='',
    author='IndikaM',
    author_email='k.indika.maligaspe@gmail.com',
    license='MIT',
    packages=['replication_service'],
    package_data={
        'replication_service':['replication_service/configs/*.yaml','requirements.txt']
    },
    include_package_data=True,
    install_requires=[]
)
