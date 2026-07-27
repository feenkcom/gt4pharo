Extension { #name : #SourceFileArray }

{ #category : #'*GToolkit-Pharo-System' }
SourceFileArray >> writeSource: aString preamble: preamble onSuccess: successBlock onFail: failBlock [
	<gtPharoPatch: #Pharo12>
	
^ GtPharoCodeModifier current critical: [
	| file position |
	file := self changesFileStream.
	(file isNil or: [ file closed or: [ file isReadOnly ] ])
		ifTrue: [ failBlock value ]
		ifFalse: [
			ChangesLog default assureStartupStampLogged.
			file setToEnd.
			file nextPutAll: preamble.
			position := file position.
			(SourceChunkWriteStream on: file) nextChunkPut: aString.
			successBlock
				cull: (self sourcePointerFromFileIndex: 2 andPosition: position)
				cull: file.
			self flushChangesFile.
			self ] ]
]
