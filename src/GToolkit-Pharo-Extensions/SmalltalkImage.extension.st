Extension { #name : #SmalltalkImage }

{ #category : #'*GToolkit-Pharo-Extensions' }
SmalltalkImage >> classInstaller [
	<gtPharoPatch: #Pharo>
	"Answer the class responsible of creating classes in the system."
	
	^ self 
		forPharo12: [ ShiftClassInstaller] 
		forPharo11: [ GtShiftClassInstaller] 
		forPharo10: [ GtShiftClassInstaller] 
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
