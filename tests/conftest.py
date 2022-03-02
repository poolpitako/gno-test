import pytest
from brownie import Contract, interface


@pytest.fixture
def user(accounts):
    yield accounts[0]


@pytest.fixture
def gno():
    yield interface.ERC20("0x9C58BAcC331c9aa871AFD802DB6379a98e80CEdb")


@pytest.fixture
def gno_whale(accounts):
    yield accounts.at("", True)


@pytest.fixture
def contract_a(ContractA, user, gno):
    yield ContractA.deploy(gno, {"from": user})


@pytest.fixture
def contract_b(ContractB, user, contract_a):
    yield ContractB.deploy(contract_a, {"from": user})
