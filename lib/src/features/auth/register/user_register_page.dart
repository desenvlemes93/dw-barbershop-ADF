import 'package:dw_barber_shop/src/core/ui/widgets/helpers/form_helper.dart';
import 'package:dw_barber_shop/src/core/ui/widgets/helpers/messages.dart';
import 'package:dw_barber_shop/src/features/auth/register/user_register_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:validatorless/validatorless.dart';

class UserRegisterPage extends ConsumerStatefulWidget {
  const UserRegisterPage({super.key});

  @override
  ConsumerState<UserRegisterPage> createState() => _UserRegisterPageState();
}

class _UserRegisterPageState extends ConsumerState<UserRegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _senhaEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _senhaEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userRegisterVm = ref.watch(userRegisterVmProvider.notifier);

    ref.listen(userRegisterVmProvider, (_, state) {
      switch (state) {
        case UserRegisterStateStatus.initial:
          break;
        case UserRegisterStateStatus.success:
          Navigator.of(context).pushNamed('/auth/register/barbershop');
        case UserRegisterStateStatus.error:
          Messages.showError('Erro ao cadastrar ADM', context);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Criar Conta'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  controller: _nameEC,
                  validator: Validatorless.required('Nome Obrigatório'),
                  decoration: const InputDecoration(
                    label: Text('Nome'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  controller: _emailEC,
                  validator: Validatorless.multiple([
                    Validatorless.required('Email Obrigatório'),
                    Validatorless.email('Email invalido'),
                  ]),
                  decoration: const InputDecoration(
                    label: Text('e-mail'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  controller: _senhaEC,
                  validator: Validatorless.multiple([
                    Validatorless.min(
                        6, 'Senha precisa ter no minino 6 caracateres'),
                  ]),
                  obscureText: true,
                  decoration: const InputDecoration(
                    label: Text('Senha'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  onTapOutside: (_) => context.unFocus(),
                  obscureText: true,
                  validator: Validatorless.compare(
                      _senhaEC, 'Senha diferente de confirma senha'),
                  decoration: const InputDecoration(
                    label: Text('Confirmar Senha'),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(56),
                  ),
                  onPressed: () {
                    switch (_formKey.currentState?.validate()) {
                      case null || false:
                        Messages.showError('Informações invalidas', context);
                      case true:
                        userRegisterVm.register(
                          name: _nameEC.text,
                          email: _emailEC.text,
                          senha: _senhaEC.text,
                        );
                    }
                  },
                  child: const Text('Criar conta'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
