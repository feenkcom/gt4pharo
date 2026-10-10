Extension { #name : #RGMetaclassStrategy }

{ #category : #'*GToolkit-Pharo-System' }
RGMetaclassStrategy >> definitionString [
	"Refer to the comment in ClassDescription|definition."

	^ String streamContents:
		[:strm |
		strm 
			<< baseClass name;
			<< ' class'.
		(self owner slotsNeedFullDefinition)
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
