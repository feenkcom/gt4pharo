Extension { #name : #SmalltalkImage }

{ #category : #'*GToolkit-Pharo-Extensions' }
SmalltalkImage >> classInstaller [
	<gtPharoPatch: #Pharo>
	"Answer the class responsible of creating classes in the system."
	
	^ self 
		forPharo12AndNewer: [ GtShiftClassInstaller12] 
		forPharo11: [ GtShiftClassInstaller] 
]

{ #category : #'*GToolkit-Pharo-Extensions' }
SmalltalkImage >> commandLineString [
	"Answer an approximation of the command line used to start the receiver.
	This will exclude VM specific arguments, `--` and maybe other things."

	^ String streamContents: [ :stream |
		stream
			<< self vm binary fullName;
			space;
			<< self vm imagePath;
			space.
		(self argumentsStartingAtIndex: 0) reversed
			do: [ :arg | stream << arg asString ]
			separatedBy: [ stream space ] ]
]

{ #category : #'*GToolkit-Pharo-Extensions' }
SmalltalkImage >> logErrorMessage: errMsg [ 

	self logStdErrorDuring: [ :stderr|
		stderr
			nextPutAll: errMsg; cr].

	self logDuring: [:logger |
		logger
			nextPutAll: 'THERE_BE_DRAGONS_HERE'; cr;
		  	nextPutAll: errMsg; cr.
		" write some type of separator"
		logger nextPutAll: (String new: 79 withAll: $- ); cr; cr]
]
