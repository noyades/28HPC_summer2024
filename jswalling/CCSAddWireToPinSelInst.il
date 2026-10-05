procedure(CCSAddWireToPinSelInst(pinName myLabel)

let((instList cv)
cv=geGetEditCellView()

instList=geGetSelSet()

if(instList
	then
	 CCSCreateWireForFloatingInstPinSelInst(cv instList pinName myLabel)

                      schCheck(cv)

else printf("Instance not selected")
)

           ) ;let
) ;proc

procedure(CCSCreateWireForFloatingInstPinSelInst(cv instList pinName myLabel)


let( ( left_E right_E top_E bot_E grid selBox ibox dir wireDir lab_x lab_y instTermbBox xa xb ya yb x1 y1 instTermList actualList mywire )


foreach(inst instList
;; This section is to filter out instTerms with external connections
instTermList =setof(x inst~>instTerms x~>name==pinName)
actualList = nil
            foreach(term instTermList
                        unless(term~>net~>figs actualList = reverse(append( list(term) actualList))
                        ) ;unless
            ) ;foreach
            foreach(ter actualList
                        unless(ter~>net~>figs
                        ;; need to get the origin for the instPins
                        instTermbBox = dbTransformBBox(car(ter~>term~>pins~>fig~>bBox) inst~>transform)
                        ;; calculate the center of instTerm
                        xa = caar(instTermbBox)
                        xb = caadr(instTermbBox)
                        ya = cadar(instTermbBox)
                        yb = cadadr(instTermbBox)
                        x1 = (xa + xb)/2
                        y1 = (ya + yb)/2
selBox=setof(x inst~>master~>shapes x~>lpp=='("instance" "drawing"))
ibox=geTransformUserBBox(car(selBox)~>bBox inst~>transform)
left_E=leftEdge(ibox)
right_E=rightEdge(ibox)
top_E=topEdge(ibox)
bot_E=bottomEdge(ibox)
grid=2*schGetEnv("schSnapSpacing")
cond(
            ((x1-grid)<left_E
            dir="R180"
            wireDir=list(x1:y1 x1-0.0625:y1)
            lab_x=x1-0.04
            lab_y=y1
            ) ;left_Edge
        
            ((x1+grid)>right_E
            dir="R0"
            wireDir=list(x1:y1 x1+0.0625:y1)
            lab_x=x1+0.04
            lab_y=y1
            ) ; right_Edge
        
            ((y1-grid)<bot_E
            dir="R270"
            wireDir=list(x1:y1 x1:y1-0.0625)
            lab_x=x1
            lab_y=y1-0.04
            ) ; bottom_Edge
        
            ((y1+grid)>top_E
            dir="R90"
            wireDir=list(x1:y1 x1:y1+0.0625)
            lab_x=x1
            lab_y=y1+0.04
            ) ; top_Edge
        
            (t
            dir="R0"
            wireDir=list(x1:y1 x1+0.0625:y1)
            lab_x=x1+0.04
            lab_y=y1
            ) ; default
) ;cond
mywire=schCreateWire(cv "draw" "full" wireDir 0.0625 0.0625 0.0)
schCreateWireLabel(cv car(mywire) lab_x:lab_y myLabel "upperLeft" dir "fixed" 0.0625 nil)
                        );unless
            );foreach actualList
); foreach instList
printf("\nDONE\n")

);let
);procedure

