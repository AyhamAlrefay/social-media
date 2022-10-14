import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:whatsapp/features/chat/domain/entities/message.dart';

import '../../../domain/entities/message_reply.dart';

part 'save_data_event.dart';
part 'save_data_state.dart';

class SaveDataBloc extends Bloc<SaveDataEvent, SaveDataState> {
  SaveDataBloc() : super(SaveDataInitial()) {

    on<SaveDataEvent>((event, emit) {
      MessageReply? reply;
      if(event is ChangeMessageReplyToDataEvent)
      {
        reply=event.messageReply;
        emit(ChangeMessageRelyToData(reply));

      }
       else{
         reply=null;
        emit(ChangeMessageReplyToNull());
      }

    });

      }


}
