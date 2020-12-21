pragma solidity >=0.4.22 <0.7.0;
import "remix_tests.sol"; // injected by remix-tests
import "./simple_storage.sol";

contract MyTest {
  SimpleStorage foo;

  function beforeEach() public {
    foo = new SimpleStorage();
  }

  function initialValueShouldBe100() public returns (bool) {
    return Assert.equal(foo.get(), 100, "initial value is not correct");
  }

  function valueIsSet200() public returns (bool) {
    foo.set(200);
    return Assert.equal(foo.get(), 200, "value is not 200");
  }

  function valueIsNotSet200() public returns (bool) {
    return Assert.notEqual(foo.get(), 200, "value is 200");
  }
}
