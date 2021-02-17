pageextension 50111 "Extend Item Card" extends "Item Card"
{
    layout
    {
        addafter("SAT Item Classification")
        {
            field("Visible on WebStore"; "Visible on WebStore")
            {
                ApplicationArea = All;
            }
        }
    }

    actions
    {
        // Add changes to page actions here
    }

    var
        myInt: Integer;
}