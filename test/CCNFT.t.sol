// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {Test} from "forge-std/Test.sol";
import {BUSD} from "../src/BUSD.sol";
import {CCNFT} from "../src/CCNFT.sol";

// Definición del contrato de prueba CCNFTTest que hereda de Test.
// Declaración de direcciones y dos instancias de contratos (BUSD y CCNFT).
contract CCNFTTest is Test {
    address deployer;
    address c1;
    address c2;
    address funds;
    address fees;
    BUSD busd;
    CCNFT ccnft;

    // Ejecución antes de cada prueba.
    // Inicializar las direcciones y desplgar las instancias de BUSD y CCNFT.
    function setUp() public {
        c1 = makeAddr("c1");
        c2 = makeAddr("c2");
        funds = makeAddr("funds");
        fees = makeAddr("fees");
        busd = new BUSD();
        ccnft = new CCNFT();
    }

    // Prueba de "setFundsCollector" del contrato CCNFT.
    // Llamar al método y despues verificar que el valor se haya establecido correctamente.
    function testSetFundsCollector() public {
        ccnft.setFundsCollector(funds);
        assertEq(ccnft.fundsCollector(), funds);
    }

    // Prueba de "setFeesCollector" del contrato CCNFT
    // Verificar que el valor se haya establecido correctamente.
    function testSetFeesCollector() public {
        ccnft.setFeesCollector(fees);
        assertEq(ccnft.feesCollector(), fees);
    }

    // Prueba de "setProfitToPay" del contrato CCNFT
    // Verificar que el valor se haya establecido correctamente.
    function testSetProfitToPay() public {
        ccnft.setProfitToPay(100);
        assertEq(ccnft.profitToPay(), 100);
    }

    // Prueba de "setCanBuy" primero estableciéndolo en true y verificando que se establezca correctamente.
    // Despues establecerlo en false verificando nuevamente.
    function testSetCanBuy() public {
        ccnft.setCanBuy(true);
        assertEq(ccnft.canBuy(), true);
        ccnft.setCanBuy(false);
        assertEq(ccnft.canBuy(), false);
    }

    // Prueba de método "setCanTrade". Similar a "testSetCanBuy".
    function testSetCanTrade() public {
        ccnft.setCanTrade(true);
        assertEq(ccnft.canTrade(), true);
        ccnft.setCanTrade(false);
        assertEq(ccnft.canTrade(), false);
    }

    // Prueba de método "setCanClaim". Similar a "testSetCanBuy".
    function testSetCanClaim() public {
        ccnft.setCanClaim(true);
        assertEq(ccnft.canClaim(), true);
        ccnft.setCanClaim(false);
        assertEq(ccnft.canClaim(), false);
    }

    // Prueba de "setMaxValueToRaise" con diferentes valores.
    // Verifica que se establezcan correctamente.
    function testSetMaxValueToRaise() public {
        ccnft.setMaxValueToRaise(100);
        assertEq(ccnft.maxValueToRaise(), 100);
    }

    // Prueba de "addValidValues" añadiendo diferentes valores.
    // Verificar que se hayan añadido correctamente.
    function testAddValidValues() public {
        ccnft.addValidValues(100);
        assertTrue(ccnft.validValues(100));
        ccnft.addValidValues(200);
        assertTrue(ccnft.validValues(200));
        ccnft.addValidValues(300);
        assertTrue(ccnft.validValues(300));
    }

    // Prueba de "setMaxBatchCount".
    // Verifica que el valor se haya establecido correctamente.
    function testSetMaxBatchCount() public {
        ccnft.setMaxBatchCount(100);
        assertEq(ccnft.maxBatchCount(), 100);
        ccnft.setMaxBatchCount(200);
        assertEq(ccnft.maxBatchCount(), 200);
        ccnft.setMaxBatchCount(300);
        assertEq(ccnft.maxBatchCount(), 300);
    }

    // Prueba de "setBuyFee".
    // Verificar que el valor se haya establecido correctamente.
    function testSetBuyFee() public {
        ccnft.setBuyFee(100);
        assertEq(ccnft.buyFee(), 100);
        ccnft.setBuyFee(200);
        assertEq(ccnft.buyFee(), 200);
        ccnft.setBuyFee(300);
        assertEq(ccnft.buyFee(), 300);
    }

    // Prueba de "setTradeFee".
    // Verificar que el valor se haya establecido correctamente.
    function testSetTradeFee() public {
        ccnft.setTradeFee(100);
        assertEq(ccnft.tradeFee(), 100);
        ccnft.setTradeFee(200);
        assertEq(ccnft.tradeFee(), 200);
        ccnft.setTradeFee(300);
        assertEq(ccnft.tradeFee(), 300);
    }

    // Prueba de que no se pueda comerciar cuando canTrade es false.
    // Verificar que se lance un error esperado.
    function testCannotTradeWhenCanTradeIsFalse() public {
        /*Por defecto es false */
        vm.expectRevert("Can't trade"); /*String de error exacto */
        ccnft.trade(1);
    }

    // Prueba que no se pueda comerciar con un token que no existe, incluso si canTrade es true.
    // Verificar que se lance un error esperado.
    function testCannotTradeWhenTokenDoesNotExist() public {
        ccnft.setCanTrade(true);
        vm.expectRevert("Token not exists"); /*String de error exacto */
        ccnft.trade(9999);
    }
}
