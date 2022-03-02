import pytest
from brownie import Wei

def test_run(contract_a, contract_b, gno, gno_whale, user):
    gno.transfer(contract_a, Wei("1 ether"), {"from": gno_whale})
    contract_a.setOther(contract_b, {"from": user})
    tx = contract_b.runTest({"from": user})
    assert False
