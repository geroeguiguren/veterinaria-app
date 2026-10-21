import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:veterinaria_app/app/fechas.dart';
import 'package:veterinaria_app/app/theme/app_theme.dart';
import 'package:veterinaria_app/features/admin/pages/dia_agenda_page.dart';
import 'package:veterinaria_app/features/data/datos_ejemplo.dart';
import 'package:veterinaria_app/features/models/turno.dart';

class PaginaAgenda extends StatefulWidget {
  const PaginaAgenda({super.key});

  @override
  State<PaginaAgenda> createState() => _EstadoPaginaAgenda();
}

class _EstadoPaginaAgenda extends State<PaginaAgenda> {
  DateTime _diaEnfocado = DateTime.now();

  void _abrirDia(DateTime dia) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (context) => PaginaDiaAgenda(dia: dia),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tema = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi agenda'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 440),
            child: ValueListenableBuilder<List<Turno>>(
              valueListenable: turnosAgenda,
              builder: (context, todos, _) => ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: ColoresAplicacion.superficie,
                      border: Border.all(color: ColoresAplicacion.borde),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TableCalendar<Turno>(
                      firstDay: DateTime(2024, 1, 1),
                      lastDay: DateTime(2030, 12, 31),
                      focusedDay: _diaEnfocado,
                      startingDayOfWeek: StartingDayOfWeek.monday,
                      availableCalendarFormats: const {
                        CalendarFormat.month: 'Mes',
                      },
                      availableGestures: AvailableGestures.horizontalSwipe,
                      eventLoader: turnosDelDia,
                      onDaySelected: (seleccionado, enfocado) {
                        setState(() => _diaEnfocado = enfocado);
                        _abrirDia(seleccionado);
                      },
                      onPageChanged: (enfocado) => _diaEnfocado = enfocado,
                      headerStyle: HeaderStyle(
                        formatButtonVisible: false,
                        titleCentered: true,
                        titleTextFormatter: (fecha, _) =>
                            '${nombreMes(fecha)} ${fecha.year}',
                        titleTextStyle: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: ColoresAplicacion.textoPrincipal,
                        ),
                      ),
                      daysOfWeekStyle: DaysOfWeekStyle(
                        dowTextFormatter: (fecha, _) =>
                            diasCortos[fecha.weekday - 1],
                        weekdayStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: ColoresAplicacion.textoSecundario,
                        ),
                        weekendStyle: const TextStyle(
                          fontWeight: FontWeight.w600,
                          color: ColoresAplicacion.textoSecundario,
                        ),
                      ),
                      calendarStyle: const CalendarStyle(
                        outsideDaysVisible: false,
                        todayDecoration: BoxDecoration(
                          color: ColoresAplicacion.principal,
                          shape: BoxShape.circle,
                        ),
                        markerDecoration: BoxDecoration(
                          color: ColoresAplicacion.secundario,
                          shape: BoxShape.circle,
                        ),
                        markersMaxCount: 3,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Tocá un día para ver sus turnos',
                    style: tema.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}