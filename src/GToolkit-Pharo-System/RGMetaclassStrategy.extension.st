Extension { #name : #RGMetaclassStrategy }

{ #category : #'*GToolkit-Pharo-System' }
RGMetaclassStrategy >> definitionString [
	"Refer to the comment in ClassDescription|definition."

	^ String streamContents:
		[:strm |
		strm 
			<< baseClass name;
			<< ' class'.
		(self owner slotsNeedFullDefinition or: [ self forPharo12: [false] forPharo11AndPharo10: [ClassDefinitionPrinter showFluidClassDefinition] ])
			ifFalse: [
						strm
							crtab;
							nextPutAll: 'instanceVariableNames: ';
							store: self owner instanceVariablesString]
			ifTrue: [
						strm
							crtab;
							nextPutAll: 'slots: ';
							nextPutAll: self owner slotDefinitionString]]
]
