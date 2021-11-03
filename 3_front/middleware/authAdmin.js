export default function ({ store, redirect }) {
    // Si l'utilisateur n'est pas admin
    if (store.state.userIsAdmin === 0) {
        return redirect('/connect')
    }
}