page 50164 "Diagnostics Document"
{
    ApplicationArea = All;
    Caption = 'Diagnostics Document';
    PageType = Card;
    SourceTable = "Diagnostics Header";

    layout
    {
        area(content)
        {
            group(General)
            {
                Caption = 'General';

                field("Document No"; Rec."Document No")
                {
                    ApplicationArea = All;
                    ShowMandatory = true;
                }
                field("Patient No"; Rec."Patient No")
                {
                    ApplicationArea = All;
                }
                field("First Name"; Rec."First Name")
                {
                    ApplicationArea = All;
                }
                field("Last Name"; Rec."Last Name")
                {
                    ApplicationArea = All;
                }
                field("Blood Group"; Rec."Blood Group")
                {
                    ApplicationArea = All;
                }
                field(Genotype; Rec.Genotype)
                {
                    ApplicationArea = All;
                }
                field(Doctor; Rec.Doctor)
                {
                    ApplicationArea = All;
                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = All;
                }
            }
            part(Lines; "Diagnostics Subpage")
            {
                ApplicationArea = All;
                Caption = 'Lines';
                SubPageLink = "Document No" = field("Document No");
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action(CreateUpdateOrder)
            {
                ApplicationArea = All;
                Caption = 'Create/Update Order';
                Image = CreateDocumentSet;
                trigger OnAction()
                var
                    DiagnosticsOrderSync: Codeunit "Diagnostics Order Sync";
                begin
                    DiagnosticsOrderSync.Run(Rec);
                    CurrPage.Update(false);
                    Message('Order %1 has been created/updated.', Rec."Order No");
                end;
            }
        }
    }
}
