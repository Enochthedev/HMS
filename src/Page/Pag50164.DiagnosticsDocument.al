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
                    Editable = DocumentNotClosed;
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
                    Editable = DocumentNotClosed;
                }
                field("Order No"; Rec."Order No")
                {
                    ApplicationArea = All;
                }
                field(Closed; Rec.Closed)
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
                Enabled = DocumentNotClosed;
                trigger OnAction()
                var
                    DiagnosticsOrderSync: Codeunit "Diagnostics Order Sync";
                begin
                    if not Confirm('Do you want to create/update the sales order for this document?') then
                        exit;
                    DiagnosticsOrderSync.Run(Rec);
                    CurrPage.Update(false);
                    Message('Order %1 has been created/updated.', Rec."Order No");
                end;
            }
            action(CloseDocument)
            {
                ApplicationArea = All;
                Caption = 'Close Document';
                Image = Close;
                Enabled = DocumentNotClosed;
                trigger OnAction()
                begin
                    if not Confirm('Do you want to close this document? No further changes will be allowed.') then
                        exit;
                    Rec.Closed := true;
                    Rec.Modify(true);
                    CurrPage.Update(false);
                    Message('Document %1 has been closed.', Rec."Document No");
                end;
            }
        }
    }

    trigger OnAfterGetRecord()
    begin
        DocumentNotClosed := not Rec.Closed;
    end;

    trigger OnNewRecord(BelowxRec: Boolean)
    begin
        DocumentNotClosed := true;
    end;

    var
        DocumentNotClosed: Boolean;
}
