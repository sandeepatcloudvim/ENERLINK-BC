pageextension 50108 ExtendItemList extends "Item List"
{
    layout
    {
        modify(InventoryField)
        {
            Caption = 'Qty On Hand';
        }
        addbefore("Substitutes Exist")
        {
            field(Qty_Available; Qty_Available)
            {
                Caption = 'Qty Available';
                ApplicationArea = all;
            }
        }
        addbefore(Qty_Available)
        {
            field("Qty. on Purch. Order"; "Qty. on Purch. Order")
            {
                ApplicationArea = All;
            }
            field("Qty. on Sales Order"; "Qty. on Sales Order")
            {
                ApplicationArea = All;
            }
            field("Visible on WebStore"; "Visible on WebStore")
            {
                ApplicationArea = All;
            }
        }

    }

    actions
    {
        addbefore("Item Journal")
        {
            action("Print Label")
            {
                ApplicationArea = all;
                Caption = 'Print Label';
                Promoted = true;
                PromotedCategory = Process;
                Image = Print;
                trigger OnAction()
                begin
                    CurrPage.SetSelectionFilter(Rec);
                    REPORT.RUN(50203, TRUE, FALSE, Rec);
                    Reset();
                end;

            }

        }
    }


    var
        myInt: Integer;
        Item: Record Item;

    trigger OnAfterGetRecord()
    begin
        item.Get("No.");
        Item.CalcFields(Inventory);
        Item.CalcFields("Qty. on Sales Order");
        Qty_Available := item.Inventory - item."Qty. on Sales Order";
    end;
}