tableextension 50002 ExtendPurchaseLine extends "Purchase Line"
{
    fields
    {
        field(50000; "Quantity on Hand"; Decimal)
        {
            Caption = 'Qty on Hand';
            Editable = false;
            DecimalPlaces = 0 : 5;
        }
        field(50001; "Qty Available"; Decimal)
        {
            Caption = 'Qty Available';
            Editable = false;
            DecimalPlaces = 0 : 5;
        }
        modify("No.")
        {
            trigger OnAfterValidate()
            begin
                GetItemDataForPurcahse("No.");
            end;
        }
        modify(Quantity)
        {
            trigger OnAfterValidate()
            begin
                GetItemDataForPurcahse("No.");
            end;
        }
    }

    var
        myInt: Integer;
        recItem: Record Item;

    procedure GetItemDataForPurcahse(ItemNo: Code[20])
    begin
        if recItem.Get(ItemNo) then begin
            recItem.CalcFields(Inventory, "Qty. on Sales Order");
            "Quantity on Hand" := recItem.Inventory;
            "Qty Available" := (recItem.Inventory - recItem."Qty. on Sales Order");
        end;
    end;
}