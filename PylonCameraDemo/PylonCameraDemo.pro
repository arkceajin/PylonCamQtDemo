QT += quick multimedia
CONFIG += c++11

# Define pylon path if not already; cannot anticipate user will ahve the env variable PYLON_DEV_DIR locked and loaded. 
# Also, assumee it lives at /opt/pylon/; if this is not the case this will need to be updated.

!defined(PYLON_DEV_DIR) {
    PYLON_DEV_DIR = $$shell_path(/opt/pylon)
}

# Make sure we can include pylon headers, etc.
INCLUDEPATH +=  $$shell_path($$PYLON_DEV_DIR/include)

# Need to be more verbose about pylon libs with unix. 
unix{
    PYLON_LIBS = $$shell_path($$PYLON_DEV_DIR/lib)
    message("unix build")
    LIBS += -L$$shell_path($$PYLON_DEV_DIR/lib) -lpylonbase \
            -lpylonutility \
            -lGenApi_gcc_v3_1_Basler_pylon \
            -lGCBase_gcc_v3_1_Basler_pylon
}
win32 {
    !contains(QMAKE_TARGET.arch, x86_64) {
        message("x86 build")
        LIBS += -L$$(PYLON_DEV_DIR)/lib/Win32
    } else {
        message("x86_64 build")
        LIBS += -L$$(PYLON_DEV_DIR)/lib/x64
    }
}
message($$PYLON_DEV_DIR)

# The following define makes your compiler emit warnings if you use
# any feature of Qt which as been marked deprecated (the exact warnings
# depend on your compiler). Please consult the documentation of the
# deprecated API in order to know how to port your code away from it.
DEFINES += QT_DEPRECATED_WARNINGS

# You can also make your code fail to compile if you use deprecated APIs.
# In order to do so, uncomment the following line.
# You can also select to disable deprecated APIs only up to a certain version of Qt.
#DEFINES += QT_DISABLE_DEPRECATED_BEFORE=0x060000    # disables all the APIs deprecated before Qt 6.0.0

SOURCES += main.cpp \
    QPylonCamera.cpp

RESOURCES += qml.qrc

# Additional import path used to resolve QML modules in Qt Creator's code model
QML_IMPORT_PATH =

# Additional import path used to resolve QML modules just for Qt Quick Designer
QML_DESIGNER_IMPORT_PATH =

# Default rules for deployment.
qnx: target.path = /tmp/$${TARGET}/bin
else: unix:!android: target.path = /opt/$${TARGET}/bin
!isEmpty(target.path): INSTALLS += target

HEADERS += \
    QPylonCamera.h
