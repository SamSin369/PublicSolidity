pragma solidity ^0.6.0;

contract Item {
    uint public pricePaid;
    uint public priceInWei;
    uint public index;
    ItemManager parentContract;

    constructor(ItemManager _parentContract, uint _priceInWei, uint _index) public {
        priceInWei = _priceInWei;
        index = _index;
        parentContract = _parentContract;

    }

    receive() external payable {
        require(pricePaid == 0, "Item is paid already");
        require(priceInWei == msg.value, "Only full payments allowed");
        pricePaid += msg.value;

      (bool success) = address(parentContract).call.value(msg.value)(abi.encodeWithSignature("triggerPayment(uint256)", index));
       require(success, "The Transaction was not successful");

    }

   
}

contract ItemManager{
    enum SupplyChainSteps{Created, Paid, Delivered}

    struct S_Item {
        Item _item;
        ItemManager.SupplyChainSteps _step;
        string _identifier;
        uint _priceInWei;

    }
    mapping(uint => S_Item) public items;

    uint itemIndex;

    event SupplyChainStep(uint _itemIndex, uint _step);

    function createItem(string memory _identifier, uint _priceInWei) public {
            Item item = new Item(this, _itemPrice, itemIndex);
            items[itemIndex]._item = item;
            items[itemIndex]._priceInWei = _priceInWei;
            items[itemIndex]._step = SupplyChainSteps.Created;
            items[itemIndex]._identifier = _identifier;
            emit SupplyChainStep(index, uint(items[index]._step, address(item)));
            itemIndex++;
    }
    function triggerPayment(uint _index) public payable {
            require(items[_index]._priceInWei <= msg.value, "Not fully paid");
            require(items[_index]._step == SupplyChainSteps.Created, "Item is further in the supply chain");
            items[_index]._step = SupplyChainSteps.Paid;
            emit SupplyChainStep(_index, uint(items[_index]._step), address(items[_itemIndex]._item));
    }
    function triggerDelivery(uint _index) public {
        require(items[_index]._step == SupplyChainSteps.Paid, "Item is further in the supply chain", address(items[_itemIndex]._item));
        items[_index]._step = SupplyChainSteps.Delivered;
        emit SupplyChainStep(_index, uint(items[_index]._step));
    }
}